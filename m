From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000668]: AC3 passthrough works up to 2.6.10-rc1 but not under rc2
Date: Wed, 23 Mar 2005 17:17:05 +0100
Message-ID: <cd089eee81de3905667ebcfe157d28a2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 68BCE289
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2005 17:17:05 +0100 (MET)
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
Last Modified:              03-23-2005 17:17 CET
======================================================================
Summary:                    AC3 passthrough works up to 2.6.10-rc1 but not under
rc2
Description: 
I have checked the changelog but I don't know what exactly have changed to
see which change breake the AC3 passtrough ?
======================================================================

----------------------------------------------------------------------
 jdthood - 03-23-05 15:23 
----------------------------------------------------------------------
Submitter: Does AC3 passthru work when you build and use the latest ALSA
modules from the alsa-driver tarball instead of the modules that come with
your 2.6 kernel?

----------------------------------------------------------------------
 Gregoire - 03-23-05 17:17 
----------------------------------------------------------------------
Sorry, as it worked since post 2.6.10-rc2 kernels, I thought you fixed this
issue.
I use now 2.6.12-rc1 and it works perfectly, would it help if I do what
you want with older kernels ?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-23-04 16:04 Gregoire       New Issue                                    
11-23-04 16:04 Gregoire       Distribution              => gentoo amd64    
11-23-04 16:04 Gregoire       Kernel Version            => 2.6.10-rc2      
11-23-04 16:08 tiwai          Note Added: 0002518                          
03-23-05 15:23 jdthood        Note Added: 0004158                          
03-23-05 17:17 Gregoire       Note Added: 0004179                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
