package com.dimple.service.impl;

import com.dimple.dao.ExamQuestionDao;
import com.dimple.dao.ExamRecordDao;
import com.dimple.dao.QuestionDao;
import com.dimple.entity.ExamQuestion;
import com.dimple.entity.ExamRecord;
import com.dimple.entity.ExamStudent;
import com.dimple.dao.ExamStudentDao;
import com.dimple.entity.Question;
import com.dimple.service.ExamStudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * 试卷和学生的关联表(ExamStudent)表服务实现类
 *
 * @author makejava
 * @since 2019-05-01 11:39:02
 */
@Service("examStudentService")
public class ExamStudentServiceImpl implements ExamStudentService {
    @Resource
    private ExamStudentDao examStudentDao;

    @Autowired
    ExamRecordDao examRecordDao;

    @Autowired
    QuestionDao questionDao;

    @Autowired
    ExamQuestionDao examQuestionDao;


    /**
     * 通过ID查询单条数据
     *
     * @param esId 主键
     * @return 实例对象
     */
    @Override
    public ExamStudent queryById(Integer esId) {
        return this.examStudentDao.queryById(esId);
    }


    /**
     * 新增数据
     *
     * @param examStudent 实例对象
     * @return 实例对象
     */
    @Override
    public ExamStudent insert(ExamStudent examStudent) {
        this.examStudentDao.insert(examStudent);
        return examStudent;
    }

    /**
     * 修改数据
     *
     * @param examStudent 实例对象
     * @return 实例对象
     */
    @Override
    public ExamStudent update(ExamStudent examStudent) {
        this.examStudentDao.update(examStudent);
        return this.queryById(examStudent.getEsId());
    }

    /**
     * 通过主键删除数据
     *
     * @param esId 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(Integer esId) {
        return this.examStudentDao.deleteById(esId) > 0;
    }

    @Override
    @Transactional
    public int finishExam(Integer examId, Integer stuId) {
        //阅卷客观题
        ReadingExamObjective(examId, stuId);
        return examStudentDao.updateStatusByExamIdAndStuId(examId, stuId, "1");
    }

    private void ReadingExamObjective(Integer examId, Integer stuId) {
        //查询出所有的question id
        List<ExamQuestion> examQuestions = examQuestionDao.selectExamQuestionListByExamId(examId);
        for (ExamQuestion examQuestion : examQuestions) {
            //获取对应的question的信息
            Question question = questionDao.queryById(examQuestion.getQuestionId());
            ExamRecord examRecord = examRecordDao.selectRecordByExamIdAndQuestionIdAndStuId(examId, question.getId(), stuId);
            switch (question.getType()) {
                //单选和多选,判断
                case "1":
                case "2":
                case "4":
                    if (question.getAnswer().equals(examRecord.getAnswer())) {
                        examRecord.setFinalScore(question.getScore());
                    } else {
                        examRecord.setFinalScore(0D);
                    }
                    break;
            }
            examRecordDao.updateRecordFinalScore(examRecord);
        }
    }
}