From: Mick <mick37@gmx.de>
Subject: Re: Tenor TE8802,
	USB : clics and crackles during music play
Date: Fri, 4 Apr 2014 15:01:01 +0000 (UTC)
Message-ID: <loom.20140404T165417-983@post.gmane.org>
References: <CA+T9nP_hcPQBoQwike7oB5TfECax2MvARv0dTG9qB-RdFMuy=w@mail.gmail.com>
 <CA+T9nP-=ffsy9ftnxynUhdJK_Eev+S-MRznLz7CED-Yp3DiOjg@mail.gmail.com>
 <20140114143417.GB23764@tamtam.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id AB0D8265804
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 17:20:12 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1WW5uW-0003Bo-2m
 for alsa-devel@alsa-project.org; Fri, 04 Apr 2014 17:20:04 +0200
Received: from quantum.pq.fta-berlin.de ([141.16.82.60])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Fri, 04 Apr 2014 17:20:04 +0200
Received: from mick37 by quantum.pq.fta-berlin.de with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Fri, 04 Apr 2014 17:20:04 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

if this isn't solved yet, I think I know the fix.
It is an issue of the TE8802 but can be fixed by a driver patch as discussed
here:
http://www.head-fi.org/t/609062/te8802-asynchronous-dacs-on-linux-and-squeezebox-touch-supported-with-triodes-app-for-the-sbt/15

It worked for me in OpenSuse + XMBC.
I'd be interested to know if this patch could make it into the regular Linux
sources.
If any, please cc me direct in reply.

Mick
