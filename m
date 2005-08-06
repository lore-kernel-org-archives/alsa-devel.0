From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001315]: Audio output of video tuner does not work for CMI 9880
Date: Sat, 6 Aug 2005 09:42:33 +0200
Message-ID: <6c93e32333dbdb056602285b0c25331b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4B9DB1DA
	for <alsa-devel@alsa-project.org>; Sat,  6 Aug 2005 09:42:33 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1315> 
======================================================================
Reported By:                exos
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1315
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               FC3
Kernel Version:             2.6.12
======================================================================
Date Submitted:             08-06-2005 09:42 CEST
Last Modified:              08-06-2005 09:42 CEST
======================================================================
Summary:                    Audio output of video tuner does not work for CMI
9880
Description: 
snd-hda-intel with Cmedie 9880 is working fine. Anyway, it is not possible
to hear any sound from the video/tuner card. I'm using tvtime. Picture is
fine and when I physically connected an ampliefier to the audio-output
cables of the tuner card the sound was audible. But I didn't find a way to
hear this sound under Linux. I made some investigations on the chipset,
but there is no description for video "widgets".
The hardware works fine under WinXP.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-06-05 09:42 exos           New Issue                                    
08-06-05 09:42 exos           Distribution              => FC3             
08-06-05 09:42 exos           Kernel Version            => 2.6.12          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
