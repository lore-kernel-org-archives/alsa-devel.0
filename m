From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002187]: hda-intel has problems after
	Acpi S3 Sleep/Resume cycle
Date: Tue, 6 Jun 2006 13:18:39 +0200
Message-ID: <bc12e12b5ccc37a6ebd6805b348dae82@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 609FB141
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Jun 2006 13:18:39 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2187> 
======================================================================
Reported By:                fdoffizi01
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2187
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-06-2006 13:18 CEST
Last Modified:              06-06-2006 13:18 CEST
======================================================================
Summary:                    hda-intel has problems after Acpi S3 Sleep/Resume
cycle
Description: 
If I sleep and resume my laptop I have to restart alsasound services or I
get distorted sound. Also volume setting isn't persistent after
sleep/resume cycle, even if it's shown as 100% it's muted, changing it
solves of course.
Distortion is a major problem of course.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-06-06 13:18 fdoffizi01     New Issue                                    
======================================================================
