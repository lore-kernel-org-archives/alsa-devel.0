From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000864]: No Support for C-Media CMI9880
Date: Mon, 31 Jan 2005 01:57:52 +0100
Message-ID: <7612c76a5b56cd382669ccd5a2d6d3b7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E931B1B0
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2005 01:57:52 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=864> 
======================================================================
Reported By:                neverread
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   864
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-31-2005 01:57 CET
Last Modified:              01-31-2005 01:57 CET
======================================================================
Summary:                    No Support for C-Media CMI9880
Description: 
A number of the new ASUS motherboards have HD sound using the C-Media
cmi9880 chip.  I've looked through the list of supported devices and the
CMI9880 is not listed.  I expect support for the chipset to become more
common.

During the install (Through YaST) no sound device is detected at all. 
When trying to use sensible alternates (ie cmipci module by selecting
cmi87x support) the install fails.

It would be great if we could add support.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-31-05 01:57 neverread      New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
