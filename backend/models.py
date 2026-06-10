from sqlalchemy.ext.automap import automap_base

from .database import engine

Base = automap_base()

Base.prepare(autoload_with=engine)

Category = Base.classes.category
College = Base.classes.college
Course = Base.classes.course
CreditWaiver = Base.classes.credit_waiver
Department = Base.classes.department
GraduationRule = Base.classes.graduation_rule
RuleCondition = Base.classes.rule_condition
WaiverLimitRule = Base.classes.waiver_limit_rule