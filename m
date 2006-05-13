From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002120]: pmac.c doesn't compile
Date: Sat, 13 May 2006 14:13:24 +0200
Message-ID: <23a670f8e268d284d7b955229b2a391d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 58AB118E
	for <alsa-devel@alsa-project.org>; Sat, 13 May 2006 14:13:24 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2120> 
======================================================================
Reported By:                riesebie
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2120
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.17rc4
======================================================================
Date Submitted:             05-13-2006 14:13 CEST
Last Modified:              05-13-2006 14:13 CEST
======================================================================
Summary:                    pmac.c doesn't compile
Description: 
ppc/pmac.c: In function '_machine_is':
ppc/pmac.c:14: error: '_machine' undeclared (first use in this function)
ppc/pmac.c:14: error: (Each undeclared identifier is reported only once
ppc/pmac.c:14: error: for each function it appears in.)
ppc/pmac.c:14: error: '_MACH_Pmac' undeclared (first use in this
function)

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-13-06 14:13 riesebie       New Issue                                    
05-13-06 14:13 riesebie       Distribution              => Debian          
05-13-06 14:13 riesebie       Kernel Version            => 2.6.17rc4       
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
