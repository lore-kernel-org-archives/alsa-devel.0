From: "Ivica Bukvic" <ico@fuse.net>
Subject: RE: What is the current status of the alsa sound server (signal polling)?
Date: Fri, 19 Apr 2002 18:15:59 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000101c1e7ef$c91178d0$ac1f830a@ico>
References: <200204191659.g3JGxPT15571@post2.fast.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mta03.fuse.net (mx3.fuse.net [216.68.1.123])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA13360
	for <alsa-devel@alsa-project.org>; Sat, 20 Apr 2002 00:09:07 +0200
In-Reply-To: <200204191659.g3JGxPT15571@post2.fast.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: 'Paul Davis' <pbd@op.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hmmm, but it seems that on their website docs they mention that you can
use oss-sink and other audio routing in order to provide audio routing,
so I was wondering if I could use that for my purposes...

Ico



> -----Original Message-----
> From: Paul Davis [mailto:pbd@op.net]
> Sent: Friday, April 19, 2002 1:02 PM
> To: Ivica Bukvic
> Cc: alsa-devel@alsa-project.org; alsa-user@alsa-project.org
> Subject: Re: [Alsa-devel] What is the current status of the alsa sound
> server (signal polling)?
> 
> I meant to add:
> 
> >Also, what is the current status of gstreamer in this department and
> 
> gstreamer has nothing to do with this. gstreamer is an internal
> architecture/framework for a single application and has nothing to do
> with sharing audio interfaces or audio data with other processes.
> 
> --p
