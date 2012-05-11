From: =?UTF-8?B?RMOibmllbA==?= Fraga <fragabr@gmail.com>
Subject: Re: Realtek ACL892: audio gap ~ each 10 seconds?
 [SOLVED]
Date: Fri, 11 May 2012 12:51:38 -0300
Message-ID: <4fad358d.541b340a.08eb.6990@mx.google.com>
References: <jnue8p$8li$1@dough.gmane.org> <jo53ht$j45$2@dough.gmane.org>
	<jobd2a$bj$1@dough.gmane.org> <johqka$tn$1@dough.gmane.org>
	<s5hehqruvh9.wl%tiwai@suse.de>
	<4facb947.541b340a.08eb.130c@mx.google.com>
	<s5hy5oztb63.wl%tiwai@suse.de>
	<4fad162b.07b3340a.14cb.5a06@mx.google.com>
	<s5h3976akpa.wl%tiwai@suse.de>
	<4fad27d8.6974340a.5e07.6c22@mx.google.com>
	<s5hipg292s4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6266A104737
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2012 17:51:45 +0200 (CEST)
Received: by vbip1 with SMTP id p1so3025707vbi.38
	for <alsa-devel@alsa-project.org>; Fri, 11 May 2012 08:51:43 -0700 (PDT)
In-Reply-To: <s5hipg292s4.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 11 May 2012 17:05:15 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> Did you get any unsol events while you don't plug anything?
> The output about indicates that it's an unsol event from the headphone
> pin (tag=1).

	Yes! The output I sent was generated without plugging anything.

-- 
Linux 3.4.0-rc6: Saber-toothed Squirrel
http://www.youtube.com/DanielFragaBR
