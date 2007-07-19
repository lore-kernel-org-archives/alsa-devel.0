From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: underrun observed when aplay is used with mmap
Date: Thu, 19 Jul 2007 15:22:38 +0200
Message-ID: <1184851358.12039.1200985213@webmail.messagingengine.com>
References: <61445c750707190517i77a34af6icc2eccc453d1b8cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 2BCEF10384D
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Jul 2007 15:22:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <61445c750707190517i77a34af6icc2eccc453d1b8cd@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pharaoh ." <pharaoh137@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pharaoh . wrote:
> Finally I have got my driver working and now testing it using aplay. I am
> able to play a song without getting any underruns when I use read/write mode
> but when I use mmapped mode I get underrun warnings. After this if I use
> read/write mode again then I observe 1 warning of underrun. Any idea what
> could be wrong?

You forgot the link to the source code.


Regards,
Clemens
