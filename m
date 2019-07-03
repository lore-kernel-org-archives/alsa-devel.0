From: Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: [PATCH 46/46] ASoC: soc-utils: respawn dummy
	Platform
Date: Wed, 3 Jul 2019 14:39:13 +0800
Message-ID: <CA+Px+wVH0ypoeY+CrWTHmQf-LYBTB9gOFwnMY8pQ5Q3K-urCrw@mail.gmail.com>
References: <87a7e2wkll.wl-kuninori.morimoto.gx@renesas.com>
 <87ftnutr9i.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CFBE5F80058
 for <alsa-devel@alsa-project.org>; Wed,  3 Jul 2019 08:39:26 +0200 (CEST)
Received: by mail-oi1-x242.google.com with SMTP id u15so1176133oiv.0
 for <alsa-devel@alsa-project.org>; Tue, 02 Jul 2019 23:39:26 -0700 (PDT)
In-Reply-To: <87ftnutr9i.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 28, 2019 at 10:18 AM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> commit 64ee5067cf64 ("ASoC: soc-utils: remove dummy Platform") removed
> dummy Platform from ALSA SoC, but it is over-kill.
What did you mean by "over-kill"?
