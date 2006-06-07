From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002192]: Very annoying acute sound
	recorded from line-in with M5455 chip
Date: Wed, 7 Jun 2006 20:42:09 +0200
Message-ID: <f1f51f131bdce26cb5a45cae1379ee9b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BD50E164
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Jun 2006 20:42:09 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2192> 
======================================================================
Reported By:                ccasteyde
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2192
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Slackware 10.1
Kernel Version:             2.6.17-rc6
======================================================================
Date Submitted:             06-07-2006 20:42 CEST
Last Modified:              06-07-2006 20:42 CEST
======================================================================
Summary:                    Very annoying acute sound recorded from line-in with
M5455 chip
Description: 
I'm using an ULi integrated sound chip, which reports as a M5455 device,
and which works very nice with the intel8x0 driver for playback, but
recording sound from line-in input gives corrupted sound with a very acute
background sound, except when source gives silence.
I have another motherboard (very older, and still with intel8x0 compatible
chip), and it gives the same result.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-07-06 20:42 ccasteyde      New Issue                                    
06-07-06 20:42 ccasteyde      File Added: record000.wav.mp3                    
06-07-06 20:42 ccasteyde      Distribution              => Slackware 10.1  
06-07-06 20:42 ccasteyde      Kernel Version            => 2.6.17-rc6      
======================================================================
