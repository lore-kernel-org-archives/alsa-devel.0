From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000835]: Possible race condition leading to crash in gnome-volume-control
Date: Tue, 18 Jan 2005 22:49:07 +0100
Message-ID: <835315e7c54ba8f999120400481817ad@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E4EF9219
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2005 22:49:07 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=835> 
======================================================================
Reported By:                jcspray
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   835
Category:                   PCI - emu10k1
Reproducibility:            sometimes
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Ubuntu
Kernel Version:             2.6.8
======================================================================
Date Submitted:             01-18-2005 22:49 CET
Last Modified:              01-18-2005 22:49 CET
======================================================================
Summary:                    Possible race condition leading to crash in
gnome-volume-control
Description: 
The maintainer of the gstreamer-based gnome-volume-control utility believes
that a crash may be the result of a race condition in ALSA driver.

Please see http://bugzilla.gnome.org/show_bug.cgi?id=156921#c9
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-18-05 22:49 jcspray        New Issue                                    
01-18-05 22:49 jcspray        Distribution              => Ubuntu          
01-18-05 22:49 jcspray        Kernel Version            => 2.6.8           
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
