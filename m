From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Online code snapshots on ALSA server
Date: Tue, 26 Aug 2008 08:57:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0808260853420.23810@tm8103-a.perex-int.cz>
References: <Pine.LNX.4.61.0808251030050.23810@tm8103-a.perex-int.cz>
	<74eb1fe20808251815g7d7a5f8ao6c6d292cc94cfbba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id ADD4F103830
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Aug 2008 08:57:48 +0200 (CEST)
In-Reply-To: <74eb1fe20808251815g7d7a5f8ao6c6d292cc94cfbba@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sean McNamara <smcnam@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 25 Aug 2008, Sean McNamara wrote:

> Glad to hear it, Jaroslav! That's much easier than checking out from GIT.
> 
> If these are automatically updated, any idea how frequently the
> packages will be regenerated? Is it after every commit, or only at
> particular time intervals?

You can grab the latest code immediately after commit to GIT repository 
(but generation of new package takes awhile as mentioned on page when it's 
not built on server already). The package generation is triggered from the 
web server by users requesting latest package immediately.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
