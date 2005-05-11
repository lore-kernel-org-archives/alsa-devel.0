From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001101]: [VIA 8237 with ALC850] gstreamer alsasink with default device does not work but with "device=hw:0" it does
Date: Wed, 11 May 2005 22:15:19 +0200
Message-ID: <666f003bd35e3df8822d81667bcef747@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8BC0C217
	for <alsa-devel@alsa-project.org>; Wed, 11 May 2005 22:15:19 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1101> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1101
Category:                   hw specific configuration
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             05-11-2005 22:15 CEST
Last Modified:              05-11-2005 22:15 CEST
======================================================================
Summary:                    [VIA 8237 with ALC850] gstreamer alsasink with
default device does not work but with "device=hw:0" it does
Description: 
The submitter of https://bugtrack.alsa-project.org/alsa-bug/view.php?id=305189
and an interlocutor have discovered that
gstreaming to "alsasink" does not work but the same to "alsasink
device=hw:0" does work.

Please see http://bugs.debian.org/305189 for the discussion which includes
lots more detail.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-11-05 22:15 jdthood        New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
