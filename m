From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001166]: doesn't support two-channel mixing; mute missing on master volume
Date: Tue, 12 Jul 2005 15:33:48 +0200
Message-ID: <cb779292a899296c5c09d7019c1bdf0f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2DD85199
	for <alsa-devel@alsa-project.org>; Tue, 12 Jul 2005 15:33:48 +0200 (MEST)
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


The following issue has been UPDATED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1166> 
======================================================================
Reported By:                stigfjel
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1166
Category:                   alsamixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-08-2005 00:27 CEST
Last Modified:              07-12-2005 15:33 CEST
======================================================================
Summary:                    doesn't support two-channel mixing; mute missing on
master volume
Description: 
Doesn't support two-channel mixing. I can't adjust volume on separate
channels with Audigy 2 Platinum. Mute is also missing on master volume,
PCM and other controls.
======================================================================

----------------------------------------------------------------------
 jdthood - 06-08-05 19:52 
----------------------------------------------------------------------
Please try alsamixer in the 1.0.9a release and report whether or not the
situation has improved.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-08-05 00:27 stigfjel       New Issue                                    
06-08-05 19:52 jdthood        Note Added: 0004971                          
07-12-05 15:33 jdthood        Summary                  Controls => doesn't
support two-channel mixing; mute missing on master volume
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
