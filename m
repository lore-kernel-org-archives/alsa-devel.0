From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Query regarding sampling rates etc
Date: Tue, 10 Jul 2007 19:32:14 +0530
Message-ID: <61445c750707100702j4e6060bdhf31ffcf51d8e1de9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 447EB10390F
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2007 16:02:17 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id m22so955823nzf
	for <alsa-devel@alsa-project.org>; Tue, 10 Jul 2007 07:02:16 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
This is a very vague question, just thought of asking it after hours of
debugging.

I am testing my alsa driver, written for omap 730/850 based board. I am
testing it by using aplay.

Despite checking clocks, sampling rates etc many times and after doing many
combinations thereof, I cant hear anything more than a noise which changes
and becomes more like the original .wav file as I change various params like
sampling rates/clocks etc. It becomes close to the actual thing, but not
better.

Any idea what are the params I should be tweaking? I know this is h/w
dependent.

-pharaoh
