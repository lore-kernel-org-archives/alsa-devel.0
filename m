From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000668]: AC3 passthrough works up to 2.6.10-rc1 but not under rc2
Date: Wed, 23 Mar 2005 15:23:50 +0100
Message-ID: <f4e2baed77faf8df2f5b9abf7f0a3748@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7A99826B
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2005 15:23:50 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=668> 
======================================================================
Reported By:                Gregoire
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   668
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               gentoo amd64
Kernel Version:             2.6.10-rc2
======================================================================
Date Submitted:             11-23-2004 16:04 CET
Last Modified:              03-23-2005 15:23 CET
======================================================================
Summary:                    AC3 passthrough works up to 2.6.10-rc1 but not under
rc2
Description: 
I have checked the changelog but I don't know what exactly have changed to
see which change breake the AC3 passtrough ?
======================================================================

----------------------------------------------------------------------
 tiwai - 11-23-04 16:08 
----------------------------------------------------------------------
Does AC3 passthru work when you compile ALSA 1.0.7 on 2.6.10-rc1?

----------------------------------------------------------------------
 jdthood - 03-23-05 15:23 
----------------------------------------------------------------------
Submitter: Does AC3 passthru work when you build and use the latest ALSA
modules from the alsa-driver tarball instead of the modules that come with
your 2.6 kernel?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-23-04 16:04 Gregoire       New Issue                                    
11-23-04 16:04 Gregoire       Distribution              => gentoo amd64    
11-23-04 16:04 Gregoire       Kernel Version            => 2.6.10-rc2      
11-23-04 16:08 tiwai          Note Added: 0002518                          
03-23-05 15:23 jdthood        Note Added: 0004158                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
