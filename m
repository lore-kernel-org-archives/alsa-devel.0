From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001564]: default 'External Amplifier' sound setting
Date: Wed, 16 Nov 2005 16:23:54 +0100
Message-ID: <8557cf12fd0e6c4b169a0f241436ffd8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8CDEF1C5
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2005 16:23:54 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1564> 
======================================================================
Reported By:                Miguel
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1564
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 4
Kernel Version:             2.6.14-1.1637_FC4
======================================================================
Date Submitted:             11-16-2005 16:23 CET
Last Modified:              11-16-2005 16:23 CET
======================================================================
Summary:                    default 'External Amplifier' sound setting
Description: 
I am a sound newbie. I apologize for this FAQ ... I searched through
bugzilla but was unable to piece together the answer. 

This bug seems related, but it looked like to me that you were waiting for
information from the submitter:

  https://bugtrack.alsa-project.org/alsa-bug/view.php?id=79

On Dell Latitude D600 and D400 laptops, with a clean install of FC4 ... or
with all the updates, there is no sound from the built-in speakers. 

Headphones do produce sound. 

Using alsamixer and typing 'm' on the 'External Amplifier' *does* enable
the built-in speakers. 

I filed a bug at bugzilla.redhat.com ... 

  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=173250

... they essentially rejected it, saying that some systems need it ON and
other systems need it OFF


Q: Was this answer from RedHat correct? 


>From messages I have seen on mailing lists, this is a problem on more
systems than just Dell Systems. 

I would like to understand this problem a bit more and try to assist in
getting it resolved. 
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-16-05 16:23 Miguel         New Issue                                    
11-16-05 16:23 Miguel         Distribution              => Fedora Core 4   
11-16-05 16:23 Miguel         Kernel Version            => 2.6.14-1.1637_FC4
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
