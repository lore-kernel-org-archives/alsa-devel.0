From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001918]: No sound when I boot into
	Linux
Date: Thu, 8 Jun 2006 23:02:52 +0200
Message-ID: <05aba3988c2c4d0e92e43b7ed0a56abe@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CC235177
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Jun 2006 23:02:52 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1918> 
======================================================================
Reported By:                gordon3913
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1918
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             03-13-2006 03:04 CET
Last Modified:              06-08-2006 23:02 CEST
======================================================================
Summary:                    No sound when I boot into Linux
Description: 
I do not have sound every time that I boot into Linux
When I run "alsaconf" and follow the prompts in a terminal my sound will
work.
Next time I start my computer - no sound.
======================================================================

----------------------------------------------------------------------
 gordon3913 - 04-25-06 02:45 
----------------------------------------------------------------------
Tried "alsactl store" & "alsactl restore" but still does not work.
I am running Suse 10.0 on a Shuttle MV4213(N) motherboard with sound by
VIA AC'97 enhanced Audio Controller.
I keep updating my Alsa software through Yast Online Update but still with
no success.
Is there something else I could try?

----------------------------------------------------------------------
 fabum - 06-08-06 23:02 
----------------------------------------------------------------------
I have same problem.

Tried "alsactl sotre" e "restore", and did not have progress.

I use debian 3.1 and alsa drivers 10.0.11-5

I will try apt-get. If it works, I tell you all.

[]s

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-13-06 03:04 gordon3913     New Issue                                    
03-13-06 03:09 rlrevell       Note Added: 0008437                          
04-25-06 02:45 gordon3913     Note Added: 0009482                          
06-08-06 23:02 fabum          Note Added: 0010118                          
======================================================================
