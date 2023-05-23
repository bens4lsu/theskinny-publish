SELECT json_array(`post_date`,  `post_title`, `ID` , post_name,
	group_concat(wt.name, ', '), GROUP_CONCAT( wt.slug), post_content)

FROM `wpben_posts` p
left join wpben_term_relationships wtr on p.ID  = wtr.object_id 
left join wpben_term_taxonomy wtt on wtr.term_taxonomy_id  = wtt.term_taxonomy_ID
 left join wpben_terms wt on wtt.term_id = wt.term_id
where post_type = 'post' and post_status = 'publish' 
group by ID
ORDER BY `post_date` DESC
