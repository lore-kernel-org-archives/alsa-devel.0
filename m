From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000655]: E-MU 1010 (1212m/1820m)
Date: Fri, 19 Nov 2004 00:45:06 +0100
Message-ID: <f64e594dd337572191bec0007e20c758@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C2CD6258
	for <alsa-devel@alsa-project.org>; Fri, 19 Nov 2004 00:45:06 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=655> 
======================================================================
Reported By:                gaburici
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   655
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             11-19-2004 00:45 CET
Last Modified:              11-19-2004 00:45 CET
======================================================================
Summary:                    E-MU 1010 (1212m/1820m)
Description: 
It would be nice if the E-MU systems based on the 1010 PCI card (1212m and
1820m) could work with alsa. I have the 1212m, which is a 1010 with an
add-on card (0202) for two analog stero channels. The add-on is not a real
PCI card, it connects to the 1010 with a floppy cable.

The 1010 card gets detected as the (older) E-MU APS, but no sound comes
out of the 0202, even with the volume at max.
I haven't tried the ADAT or SPDIF outputs of the 1010.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-19-04 00:45 gaburici       New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
