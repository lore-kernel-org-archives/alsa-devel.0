From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000240]: Clean up the iPaq specific things (move them into another source code).
Date: Mon, 6 Jun 2005 10:22:55 +0200
Message-ID: <c1e5ad27d6c23c8183ad9204a5a5b9f9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (unknown [195.113.161.147])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 46B1C179
	for <alsa-devel@alsa-project.org>; Mon,  6 Jun 2005 10:22:56 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been UPDATED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=240> 
======================================================================
Reported By:                perex
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   240
Category:                   ARM - sa11xx-uda1341
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             04-27-2004 11:50 CEST
Last Modified:              06-06-2005 10:22 CEST
======================================================================
Summary:                    Clean up the iPaq specific things (move them into
another source code).
Description: 
See summary.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-27-04 11:50 perex          New Issue                                    
10-20-04 11:30 perex          Note Added: 0002214                          
10-20-04 11:31 perex          Note Deleted: 0002214                        
10-20-04 11:53 perex          Note Added: 0002215                          
10-20-04 11:53 perex          Note Deleted: 0002215                        
10-20-04 12:21 perex          Note Added: 0002216                          
10-20-04 12:21 perex          Note Deleted: 0002216                        
10-22-04 15:18 perex          Note Added: 0002227                          
10-22-04 15:20 perex          Note Added: 0002228                          
10-22-04 15:24 perex          Note View State: public: 2227                    
10-22-04 15:24 perex          Note View State: public: 2228                    
10-22-04 15:26 perex          Note Added: 0002229                          
10-22-04 15:26 perex          Note Added: 0002230                          
10-22-04 15:27 perex          Note Added: 0002231                          
10-22-04 15:28 perex          Note Added: 0002232                          
10-22-04 15:29 perex          Note Added: 0002233                          
10-22-04 15:32 perex          Note Added: 0002234                          
10-22-04 15:35 perex          Note Added: 0002235                          
10-22-04 15:35 perex          Note Added: 0002236                          
10-22-04 15:39 perex          Note Added: 0002237                          
10-22-04 15:46 perex          Note Added: 0002238                          
10-22-04 15:48 perex          Note Added: 0002239                          
10-22-04 15:48 perex          Note Added: 0002240                          
10-22-04 15:52 perex          Note Added: 0002241                          
10-22-04 15:55 perex          Note Added: 0002242                          
10-22-04 16:16 perex          Note Deleted: 0002242                        
10-22-04 16:17 perex          Note Deleted: 0002227                        
10-22-04 16:17 perex          Note Deleted: 0002241                        
10-22-04 16:17 perex          Note Deleted: 0002240                        
10-22-04 16:17 perex          Note Deleted: 0002228                        
10-22-04 16:18 perex          Note Deleted: 0002239                        
10-22-04 16:18 perex          Note Deleted: 0002238                        
10-22-04 16:18 perex          Note Deleted: 0002237                        
10-22-04 16:18 perex          Note Deleted: 0002230                        
10-22-04 16:18 perex          Note Deleted: 0002229                        
10-22-04 16:18 perex          Note Deleted: 0002236                        
10-22-04 16:18 perex          Note Deleted: 0002231                        
10-22-04 16:18 perex          Note Deleted: 0002232                        
10-22-04 16:19 perex          Note Deleted: 0002233                        
10-22-04 16:19 perex          Note Deleted: 0002235                        
10-22-04 16:19 perex          Note Deleted: 0002234                        
06-06-05 10:08 perex          Reproducibility          always => sometimes 
06-06-05 10:10 perex          Reproducibility          sometimes => always 
06-06-05 10:14 perex          Reproducibility          always => sometimes 
06-06-05 10:17 perex          Reproducibility          sometimes => always 
06-06-05 10:19 perex          Reproducibility          always => sometimes 
06-06-05 10:22 perex          Reproducibility          sometimes => always 
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
