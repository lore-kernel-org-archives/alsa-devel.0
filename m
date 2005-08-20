From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000493]: Sound mixer decreases volume and mutes sound channels
Date: Sat, 20 Aug 2005 15:59:27 +0200
Message-ID: <db90aa7b2230c87a6ff7414d4b954cd7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8C30E1DB
	for <alsa-devel@alsa-project.org>; Sat, 20 Aug 2005 15:59:28 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=493> 
======================================================================
Reported By:                Joe_Bogarde
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   493
Category:                   amixer
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             09-09-2004 18:32 CEST
Last Modified:              08-20-2005 15:59 CEST
======================================================================
Summary:                    Sound mixer decreases volume and mutes sound
channels
Description: 
Sound volume just drops off on its own (extigy).
gtk based mixer seems slow to respond and locks up.  I recently tried the
latest driver but downgraded to 1.0.6 to see if that helped, didn't.  It
seems lkke the extigy did fine after first boot, but after that it didn't
work too well.
======================================================================

----------------------------------------------------------------------
 jdthood - 03-20-05 13:25 
----------------------------------------------------------------------
Submitter: Any luck with later ALSA releases?

Does the sound drop in volume when mixers are running?
Does the sound drop in volume when no mixers are running?

----------------------------------------------------------------------
 jdthood - 08-20-05 15:59 
----------------------------------------------------------------------
Closing, since no further information has been provided.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-09-04 18:32 Joe_Bogarde    New Issue                                    
09-09-04 18:35 Joe_Bogarde    File Added: bug.txt                          
03-20-05 13:25 jdthood        Note Added: 0004082                          
08-20-05 15:59 jdthood        Status                   new => closed       
08-20-05 15:59 jdthood        Note Added: 0005875                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
