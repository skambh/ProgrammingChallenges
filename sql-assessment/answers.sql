/********** 1 **********/
SELECT date,
    SUM(impressions)
FROM marketing_performance
GROUP BY date;
/* RESULTS:
 2023-07-24 0:00:00|1423
 2023-07-26 0:00:00|1547
 2023-07-27 0:00:00|2295
 2023-07-28 0:00:00|8142
 2023-07-29 0:00:00|3511
 2023-07-30 0:00:00|3001
 2023-08-02 0:00:00|1532
 2023-08-03 0:00:00|3189
 2023-08-04 0:00:00|3254
 2023-08-05 0:00:00|1088
 2023-08-10 0:00:00|2128
 2023-08-11 0:00:00|2278
 2023-08-12 0:00:00|6588
 2023-08-13 0:00:00|2170
 2023-08-14 0:00:00|5773
 2023-08-17 0:00:00|3292
 2023-08-19 0:00:00|1248
 /*
 
 /********** 2 **********/
SELECT state,
    SUM(revenue)
FROM website_revenue
GROUP BY state
ORDER BY SUM(revenue) DESC
LIMIT 3;
/* 
 RESULTS:
 NY|46398
 GA|39666
 OH|37577
 The third best state (OH) generated $37577 in revenue.
 */
/********** 3 **********/
SELECT c.name,
    SUM(m.cost),
    SUM(m.impressions),
    SUM(m.clicks),
    SUM(w.revenue)
FROM campaign_info c
    INNER JOIN marketing_performance m ON c.id = m.campaign_id
    INNER JOIN website_revenue w ON c.id = w.campaign_id
GROUP BY c.name;
/*
 RESULTS:
 Campaign1|4170.51|42810|38724|151792
 Campaign2|4075.5|40938|29652|155308
 Campaign3|15809.04|158280|116048|551672
 Campaign4|3970.14|47508|33318|163396
 Campaign5|4077.15|25641|33663|136404
 */
/********** 4 **********/
SELECT m.geo,
    SUM(m.conversions)
FROM marketing_performance m
    INNER JOIN campaign_info c ON c.id = m.campaign_id
WHERE c.name = "Campaign5"
GROUP BY m.geo
ORDER BY SUM(m.conversions) DESC;
/*
 RESULTS:
 United States-GA|672
 United States-OH|442
 GA generated the most conversions for Campaign5.
 */
/********** 5 **********/
SELECT c.name,
    SUM(m.conversions) / SUM(m.cost) AS conversions_per_dollar
FROM marketing_performance m
    INNER JOIN campaign_info c ON c.id = m.campaign_id
GROUP BY c.name
ORDER BY conversions_per_dollar DESC;
/*
 RESULTS:
 Campaign4|2.34399794465686
 Campaign3|2.25238218133422
 Campaign2|2.23187338976813
 Campaign1|2.17095750879389
 Campaign5|1.91261052450854
 In my opinion, Campaign4 was the most efficient because it was able to make the most amount of conversions for each dollar spent on the campaign.
 */
/********** 6 **********/
SELECT strftime('%w', date) AS day_of_week,
    SUM(impressions) / SUM(cost)
FROM marketing_performance
GROUP BY day_of_week
ORDER BY SUM(impressions) / SUM(cost) DESC;
/*
 RESULTS:
 5|10.9852501687072
 6|10.065565808645
 3|9.89523074945366
 4|9.55552439708357
 1|9.29811866859624
 0|8.86462208355476
 The best day of the week to run ads if Friday since that's the day you're likely to get the most impressions per dollar spent.
 */