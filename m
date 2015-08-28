From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 1/3] ASoC: pxa-ssp: Convert to
	devm_snd_soc_register_component
Date: Fri, 28 Aug 2015 10:42:57 +0200
Message-ID: <87egin3isu.fsf@belgarion.home>
References: <1440730115.11149.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp12.smtpout.orange.fr
 [80.12.242.134])
 by alsa0.perex.cz (Postfix) with ESMTP id ECECD260435
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2015 10:47:23 +0200 (CEST)
In-Reply-To: <1440730115.11149.0.camel@ingics.com> (Axel Lin's message of
 "Fri, 28 Aug 2015 10:48:35 +0800")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: alsa-devel@alsa-project.org

Axel Lin <axel.lin@ingics.com> writes:

> Signed-off-by: Axel Lin <axel.lin@ingics.com>
Both patches look fine by me, except that the commit messages are empty, which
is a bit a pity for me. That would for example tell me if this was tested on any
platform, even if the patch looks trivial.

Cheers.

--
Robert
