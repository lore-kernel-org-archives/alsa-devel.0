From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000668]: AC3 passthrough works up to 2.6.10-rc1 but not under rc2
Date: Wed, 23 Mar 2005 17:21:42 +0100
Message-ID: <c900f118ae84ce478bfc059540009e49@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D9CB6289
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2005 17:21:42 +0100 (MET)
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


The following issue has been RESOLVED.
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
Status:                     resolved
Distribution:               gentoo amd64
Kernel Version:             2.6.10-rc2
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-23-2004 16:04 CET
Last Modified:              03-23-2005 17:21 CET
======================================================================
Summary:                    AC3 passthrough works up to 2.6.10-rc1 but not under
rc2
Description: 
I have checked the changelog but I don't know what exactly have changed to
see which change breake the AC3 passtrough ?
======================================================================

----------------------------------------------------------------------
 Gregoire - 03-23-05 17:17 
----------------------------------------------------------------------
Sorry, as it worked since post 2.6.10-rc2 kernels, I thought you fixed this
issue.
I use now 2.6.12-rc1 and it works perfectly, would it help if I do what
you want with older kernels ?

----------------------------------------------------------------------
 jdthood - 03-23-05 17:21 
----------------------------------------------------------------------
Just checking to make sure that the problem is indeed fixed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-23-04 16:04 Gregoire       New Issue                                    
11-23-04 16:04 Gregoire       Distribution              => gentoo amd64    
11-23-04 16:04 Gregoire       Kernel Version            => 2.6.10-rc2      
11-23-04 16:08 tiwai          Note Added: 0002518                          
03-23-05 15:23 jdthood        Note Added: 0004158                          
03-23-05 17:17 Gregoire       Note Added: 0004179                          
03-23-05 17:21 jdthood        Note Added: 0004180                          
03-23-05 17:21 jdthood        Status                   new => resolved     
03-23-05 17:21 jdthood        Resolution               open => fixed       
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
