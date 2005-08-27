From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001373]: Setting relative value is not possible with cset
Date: Sat, 27 Aug 2005 23:48:39 +0200
Message-ID: <26e5c85791b927e65d664bcadec1a69e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BC9FF213
	for <alsa-devel@alsa-project.org>; Sat, 27 Aug 2005 23:48:39 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1373> 
======================================================================
Reported By:                Griffon26
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1373
Category:                   amixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             08-27-2005 23:48 CEST
Last Modified:              08-27-2005 23:48 CEST
======================================================================
Summary:                    Setting relative value is not possible with cset
Description: 
The summary only suggests one of the two possible solutions to my problem.
I want to be able to control the volume of PCM playback using relative
values
but without touching the volume of PCM capture. 

With sset I can do the former, but not the latter. 
With cset I can do the latter, but not the former.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-27-05 23:48 Griffon26      New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
