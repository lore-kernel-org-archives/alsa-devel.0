From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002059]: Can't set external input switch for recording.
Date: Sun, 23 Apr 2006 01:03:35 +0200
Message-ID: <d4418de13119c1bffcc2405b45a89446@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C7F0514F
	for <alsa-devel@alsa-project.org>; Sun, 23 Apr 2006 01:03:35 +0200 (MEST)
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


The following issue has been set as RELATED TO issue 0001890.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2059> 
======================================================================
Reported By:                fdoffizi01
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2059
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             04-23-2006 00:56 CEST
Last Modified:              04-23-2006 01:03 CEST
======================================================================
Summary:                    Can't set external input switch for recording.
Description: 
I used the patch from bug #1890 and I got an Unknown switch to activate to
record from external line in instead of internal mic.
Now with new 1.0.11 drivers, that supports Vaio FE11x Sigmatel audio chip
I can't get it. No way to record from something different from internal
mic.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001890 Only the PCM channel in alsa mixer, unm...
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-23-06 00:56 fdoffizi01     New Issue                                    
04-23-06 01:03 rlrevell       Relationship added       related to 0001890  
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
