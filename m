From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001063]: master volume change and mute only affect front speakers on sound blaster live
Date: Thu, 21 Apr 2005 12:42:21 +0200
Message-ID: <63b328a983cef6e723a97aa4504c585b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0D6CB1B1
	for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2005 12:42:21 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1063> 
======================================================================
Reported By:                borge3
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1063
Category:                   alsamixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             04-18-2005 13:03 CEST
Last Modified:              04-21-2005 12:42 CEST
======================================================================
Summary:                    master volume change and mute only affect front
speakers on sound blaster live
Description: 
master volume change and mute only affect front speakers, rear speakers are
affected by "wave surround"

the sound card is a "sound blister live!"

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000148 Master volume only controls front output
======================================================================

----------------------------------------------------------------------
 adamk75 - 04-21-05 12:42 
----------------------------------------------------------------------
This is a known bug... Already reported a year ago as
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=154

Lee Revell thought he'd have it working real soon now back in February. 
Please continue being patient and I'm sure it'll get done.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-18-05 13:03 borge3         New Issue                                    
04-18-05 20:18 rlrevell       Relationship added       duplicate of 0000148
04-21-05 12:42 adamk75        Note Added: 0004551                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
