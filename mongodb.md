var codeAry = db.cardcodes.find({"isSold":true, "active":true, "PPPType":"S", createdOn: {$gte: new Date('2017/03/18'), $lt: new Date('2017/05/07')}}).map(function(card) {return card.PPPCode})

db.photos.aggregate([
{
    $match: {
        'customerIds.code': {$in: codeAry}
    }
},
{
    $project: {
        shootOn: 1,
        code: '$customerIds.code'
    }
},
{
    $unwind: '$code'
},
{
    $group: {
       _id: {
            code: '$code',
            year: { $year: {$add: ['$shootOn', 28800000]}},
            month: { $month: {$add: ['$shootOn', 28800000]}},
            day: {$dayOfMonth: {$add: ['$shootOn', 28800000]}}
        } 
    }
},
{
    $project: {
        _id: 0,
        code: '$_id.code',
        days: { '$concat' : [ {$substr:['$_id.year', 0, 4]}, '/', {$substr:['$_id.month', 0, 2]}, '/',{$substr:['$_id.day', 0, 2]}] }
    }
},
{
    $group: {
        _id:'$code',
        days: {$addToSet: '$days'} 
    }
},
{
    $project: {
        _id: 1,
        days: { $size : '$days' }
    }
},
{
    $group: {
        _id: '$days',
        num: { $sum : 1 }
    }
},
{
    $project: {
        _id: 0,
        days: '$_id',
        card_num: '$num'
    }
},
{
    $sort: {days: 1}
}
])