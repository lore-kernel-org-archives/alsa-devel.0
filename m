From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000882]: Sound stops working in two scenarios with snd-via82xx module
Date: Thu, 3 Feb 2005 18:59:49 +0100
Message-ID: <3f8e2c94f3d0228bcdb454275c9dfe24@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 245DF205
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2005 18:59:50 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=882> 
======================================================================
Reported By:                rob
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   882
Category:                   PCI - via82xx
Reproducibility:            sometimes
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Redhat 9
Kernel Version:             2.4.22
======================================================================
Date Submitted:             02-03-2005 18:59 CET
Last Modified:              02-03-2005 18:59 CET
======================================================================
Summary:                    Sound stops working in two scenarios with
snd-via82xx module
Description: 
Sound normally works fine, but we have problems a large percentage of the
time when booting after a day or two of the systems being off, or less
frequently if I unplug/replug or turn on/off amplified speakers.  It seems
to vary from machine to machine even with identical hardware.

This is a major annoyance for us as we have many of these systems which
we're trying to use in an educational setting with audio.  We can work
around it, but it's not ideal.  If only it had showed up in our initial
testing!


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-03-05 18:59 rob            New Issue                                    
02-03-05 18:59 rob            Distribution              => Redhat 9        
02-03-05 18:59 rob            Kernel Version            => 2.4.22          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
