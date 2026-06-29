// Task 60
db = db.getSiblingDB("college_nosql");

// Task 61-63
db.feedback.insertMany([
{
student_id:1,
course_code:"CS101",
semester:"2022-ODD",
rating:5,
comments:"Excellent teaching. Would recommend.",
tags:["challenging","well-structured","good-examples"],
submitted_at:new Date("2022-11-30T10:15:00Z"),
attachments:[{filename:"notes.pdf",size_kb:240}]
},
{
student_id:2,
course_code:"CS101",
semester:"2022-ODD",
rating:4,
comments:"Very informative.",
tags:["challenging","interesting"],
submitted_at:new Date("2022-11-29T10:15:00Z"),
attachments:[{filename:"assignment.pdf",size_kb:180}]
},
{
student_id:3,
course_code:"CS101",
semester:"2021-EVEN",
rating:2,
comments:"Needs improvement.",
tags:["difficult","challenging"],
submitted_at:new Date("2021-11-29T10:15:00Z"),
attachments:[{filename:"feedback.pdf",size_kb:120}]
},
{
student_id:4,
course_code:"CS102",
semester:"2022-ODD",
rating:5,
comments:"Excellent course.",
tags:["practical","good-examples"],
submitted_at:new Date("2022-11-30T10:15:00Z"),
attachments:[{filename:"lab.pdf",size_kb:210}]
},
{
student_id:5,
course_code:"CS102",
semester:"2022-EVEN",
rating:3,
comments:"Average.",
tags:["basic","easy"],
submitted_at:new Date("2022-05-20T10:15:00Z"),
attachments:[{filename:"project.pdf",size_kb:350}]
},
{
student_id:6,
course_code:"CS103",
semester:"2022-ODD",
rating:1,
comments:"Poor explanation.",
tags:["confusing","boring"],
submitted_at:new Date("2022-11-25T10:15:00Z"),
attachments:[{filename:"review.pdf",size_kb:100}]
},
{
student_id:7,
course_code:"CS104",
semester:"2022-ODD",
rating:4,
comments:"Good faculty.",
tags:["interactive","interesting"],
submitted_at:new Date("2022-11-20T10:15:00Z"),
attachments:[{filename:"report.pdf",size_kb:160}]
},
{
student_id:8,
course_code:"CS105",
semester:"2021-EVEN",
rating:2,
comments:"Can improve.",
tags:["boring","lengthy"],
submitted_at:new Date("2021-11-10T10:15:00Z"),
attachments:[{filename:"notes.pdf",size_kb:200}]
},
{
student_id:9,
course_code:"CS106",
semester:"2022-ODD",
rating:5,
comments:"Loved it.",
tags:["well-structured","good-examples"],
submitted_at:new Date("2022-11-18T10:15:00Z"),
attachments:[{filename:"slides.pdf",size_kb:400}]
},
{
student_id:10,
course_code:"CS107",
semester:"2022-ODD",
rating:3,
comments:"Decent.",
tags:["basic"],
submitted_at:new Date("2022-11-22T10:15:00Z")
}
])

// Task 64
db.feedback.countDocuments()

// Task 65
db.feedback.find({rating:5})

// Task 66
db.feedback.find({
    course_code:"CS101",
    tags:"challenging"
})

// Task 67
db.feedback.find(
{},
{
_id:0,
student_id:1,
course_code:1,
rating:1
}
)

// Task 68
db.feedback.updateMany(
{rating:{$lt:3}},
{$set:{needs_review:true}}
)

// Task 69
db.feedback.updateMany(
{needs_review:true},
{$push:{tags:"reviewed"}}
)

// Task 70
db.feedback.deleteMany({
semester:"2021-EVEN"
})

// Task 71
db.feedback.aggregate([
{$match:{semester:"2022-ODD"}},
{$group:{
_id:"$course_code",
avg_rating:{$avg:"$rating"},
feedback_count:{$sum:1}
}},
{$sort:{avg_rating:-1}}
])

// Task 72
db.feedback.aggregate([
{$match:{semester:"2022-ODD"}},
{$group:{
_id:"$course_code",
avg_rating:{$avg:"$rating"},
feedback_count:{$sum:1}
}},
{$project:{
_id:0,
course_code:"$_id",
average_rating:{$round:["$avg_rating",1]},
feedback_count:1
}},
{$sort:{average_rating:-1}}
])

// Task 73
db.feedback.aggregate([
{$unwind:"$tags"},
{$group:{
_id:"$tags",
count:{$sum:1}
}},
{$sort:{count:-1}}
])

// Task 74
db.feedback.createIndex({course_code:1})

db.feedback.find({
course_code:"CS101"
}).explain("executionStats")