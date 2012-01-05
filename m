From: Joachim  Eastwood <manabian@gmail.com>
Subject: Re: [PATCH] asoc: replace 0xffffffff with DMA_BIT_MASK
	macro
Date: Thu, 5 Jan 2012 17:31:14 +0100
Message-ID: <CAGhQ9VxiCpZdNWRfwMgbg6Jam7pcffdUs7xuMiQYaFJ1FfV-AA@mail.gmail.com>
References: <1325382183-21717-1-git-send-email-manabian@gmail.com>
	<20120102132933.GN4300@opensource.wolfsonmicro.com>
	<CAGhQ9VyxHvCFy4EJyabi8Tfy5NRQaOe4huAPXVYsrQ0GBDsc9g@mail.gmail.com>
	<20120105053625.GA11867@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-tul01m020-f179.google.com (mail-tul01m020-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 85E8A244DA
	for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2012 17:31:15 +0100 (CET)
Received: by obcwm4 with SMTP id wm4so800932obc.38
	for <alsa-devel@alsa-project.org>; Thu, 05 Jan 2012 08:31:14 -0800 (PST)
In-Reply-To: <20120105053625.GA11867@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Joachim Eastwood <joachim.eastwood@jotron.com>, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 5, 2012 at 6:36 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Jan 04, 2012 at 07:04:29PM +0100, Joachim Eastwood wrote:
>> On Mon, Jan 2, 2012 at 2:29 PM, Mark Brown
>
>> > Please also use subject lines corresponding to the subsystem.
>
>> The subject of this mail includes "asoc". Is there anything I should
>> do different?
>
> If you look at all the other commits in the subsystem you'll see they're
> for "ASoC".
Yes, I see. Do you want me to resend with proper subject?

One other thing; which git tree should I base them on? The ones I sent
was based on Linus master.

regards
Joachim Eastwood
