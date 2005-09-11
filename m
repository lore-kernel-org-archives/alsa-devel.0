From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001414]: Hercules Digifire - ADC control only mutes left channel
Date: Sun, 11 Sep 2005 19:12:16 +0200
Message-ID: <2a6100820e61ec1b8999bddfb296ffe0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AD819168
	for <alsa-devel@alsa-project.org>; Sun, 11 Sep 2005 19:12:16 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1414> 
======================================================================
Reported By:                a_r_schulz
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1414
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Mandrivia
Kernel Version:             2.6.13
======================================================================
Date Submitted:             09-11-2005 19:12 CEST
Last Modified:              09-11-2005 19:12 CEST
======================================================================
Summary:                    Hercules Digifire - ADC control only mutes left
channel
Description: 
I would like to use my card for recording with audacity in LINUX, but it's
a little hard to get the levels right, since the ADC slider in both
alsamixer and kmix affect only the left input channel, leaving the right
channel at full volume. Had this problem with all 2.6 kernel versions so
far, but did not really care up to now...
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-11-05 19:12 a_r_schulz     New Issue                                    
09-11-05 19:12 a_r_schulz     Distribution              => Mandrivia       
09-11-05 19:12 a_r_schulz     Kernel Version            => 2.6.13          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
