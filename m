From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001132]: Realtek ALC260, snd-hda-intel, 2.4.21-32, catastrophic CrAsH
Date: Sat, 28 May 2005 02:02:43 +0200
Message-ID: <22b5ddab8e9bc9c30fd67526b666b4c6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D0DD818D
	for <alsa-devel@alsa-project.org>; Sat, 28 May 2005 02:02:43 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1132> 
======================================================================
Reported By:                speedking
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1132
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               RHEL 3 U5 gold
Kernel Version:             2.4.21-32
======================================================================
Date Submitted:             05-28-2005 02:02 CEST
Last Modified:              05-28-2005 02:02 CEST
======================================================================
Summary:                    Realtek ALC260, snd-hda-intel, 2.4.21-32,
catastrophic CrAsH
Description: 
system hangs when either 'alsaconf' runs or you attempt a 'modprobe
snd-hda-intel'

System is a HP xw4300 workstation, Intel based, running an Azalia
compliant" "Intel High definition Audio" Realtek ALC 260 chip onboard.




======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-28-05 02:02 speedking      New Issue                                    
05-28-05 02:02 speedking      Distribution              => RHEL 3 U5 gold  
05-28-05 02:02 speedking      Kernel Version            => 2.4.21-32       
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
