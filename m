From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002334]: Microphone doesn't work
Date: Fri, 4 Aug 2006 23:46:48 +0200
Message-ID: <c04308a2d243508fcb0f63a7b1a77168@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E6A0914F
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Aug 2006 23:46:48 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2334> 
======================================================================
Reported By:                extremecarver
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2334
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Dapper (Gnome and XFCE both no difference)
Kernel Version:             2.6.12.2 - beyond1.1
======================================================================
Date Submitted:             08-04-2006 23:46 CEST
Last Modified:              08-04-2006 23:46 CEST
======================================================================
Summary:                    Microphone doesn't work
Description: 
Actually the hardware is a Sigmatel 9200 chip STAC9200, on a dell 630m
laptop. with intel 915chipset: When recording in gnome recorder i only
hear noise. In skype I hear nothing.

I compiled from source using the following settings:
http://ubuntuforums.org/showthread.php?t=195434&highlight=hda-intel

except that I changed to 1.0.12rc2
Also 1.12rc1 did not work. 

There is also a thread under
http://www.ubuntuforums.org/showthread.php?t=206606&highlight=alsa+compile

The microphone problem should have been solved in 1.0.11rc5 but it doesn't
seem to work for anyone.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-04-06 23:46 extremecarver  New Issue                                    
08-04-06 23:46 extremecarver  Distribution              => Ubuntu Dapper (Gnome
and XFCE both no difference)
08-04-06 23:46 extremecarver  Kernel Version            => 2.6.12.2 - beyond1.1
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
