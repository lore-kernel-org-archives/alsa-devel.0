From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 0/1] ASoC: TWL4030: Headset ramp down fix
Date: Tue, 12 May 2009 08:33:04 +0300
Message-ID: <20090512083304.1d91f188.jhnikula@gmail.com>
References: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
	<dfeb90390905110557m79ce9a51n5b8b73e5a736d05b@mail.gmail.com>
	<2ee9e08d0905112059x52fc667fu91e7eb34082d3ad3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B38124676
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 07:31:26 +0200 (CEST)
Received: by ewy23 with SMTP id 23so4319044ewy.32
	for <alsa-devel@alsa-project.org>; Mon, 11 May 2009 22:31:25 -0700 (PDT)
In-Reply-To: <2ee9e08d0905112059x52fc667fu91e7eb34082d3ad3@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Anuj Aggarwal <anuj.aggarwal@gmail.com>
Cc: alsa-devel@alsa-project.org, "Aarti Dewan (Corp HR),
	Noida" <Aarti.Dewan@hcl.in>, broonie@opensource.wolfsonmicro.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>, sakoman@gmail.com, anuj.aggarwal@ti.com, Arun KS <getarunks@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 12 May 2009 09:29:55 +0530
Anuj Aggarwal <anuj.aggarwal@gmail.com> wrote:

> Moreover, I am hearing a sine-tonish kind of sound, always in the
> beginning. It lasts only for less than a sec but is very prominent
> and occurs always.
> 
> Has anyone noticed this too?
> 
I haven't noticed (yet) but can you post your use case here how to
reproduce it. It would help to hunt is the problem OMAP & TWL4030
specific or is it somewhere else.


-- 
Jarkko
