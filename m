From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000785]: Add support to quickly change volume
Date: Fri, 7 Jan 2005 18:25:31 +0100
Message-ID: <353a7dde62e7ca7a0bf1b7b4e66a7b45@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 81BC624F
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2005 18:25:31 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=785> 
======================================================================
Reported By:                nijel
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   785
Category:                   alsamixer
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-05-2005 12:27 CET
Last Modified:              01-07-2005 18:25 CET
======================================================================
Summary:                    Add support to quickly change volume
Description: 
Attached patch adds support for quickly changing volume using 0-9 keys in
simmilar way as aumix does.
======================================================================

----------------------------------------------------------------------
 nijel - 01-05-05 14:00 
----------------------------------------------------------------------
Added new patch to fix muting on start, I forgot to set initial value
correctly.

----------------------------------------------------------------------
 tiwai - 01-07-05 18:25 
----------------------------------------------------------------------
Well, I already assigned some number keys for alternatives to F1-F5.
I think this feature is very nice, so we need to reassign keys.
Any suggestions?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-05-05 12:27 nijel          New Issue                                    
01-05-05 12:27 nijel          File Added: alsamixer-numbers.patch               
    
01-05-05 14:00 nijel          File Added: alsamixer-numbers2.patch              
     
01-05-05 14:00 nijel          Note Added: 0003089                          
01-07-05 18:25 tiwai          Note Added: 0003110                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
