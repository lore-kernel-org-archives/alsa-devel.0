From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 2/3] ALSA: ASoC: McASP: determine XSSZ
	value programatically
Date: Thu, 06 Dec 2012 12:21:33 +0100
Message-ID: <50C07FBD.3000804@gmail.com>
References: <1354721862-10318-1-git-send-email-zonque@gmail.com>
 <1354721862-10318-2-git-send-email-zonque@gmail.com>
 <50BF81CC.2030008@gmail.com>
 <1BAFE6F6C881BF42822005164F1491C33EB00050@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 00970260314
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2012 12:21:35 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so2519346bkc.38
 for <alsa-devel@alsa-project.org>; Thu, 06 Dec 2012 03:21:35 -0800 (PST)
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EB00050@DBDE01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: "Porter, Matt" <mporter@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Nori, Sekhar" <nsekhar@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
List-Id: alsa-devel@alsa-project.org

On 06.12.2012 04:18, Hebbar, Gururaja wrote:
> On Wed, Dec 05, 2012 at 22:48:04, Daniel Mack wrote:
>> On 05.12.2012 16:37, Daniel Mack wrote:
>>> This shouldn't change any functionality and is just a preparation a
>>> special case handling.
>>>
>>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>>
>> Hold on - I found another way that even does more cleanups. I'll
>> resubmit a v2.
> 
> Kindly add a cover letter and mention what is/will be changed in V2
> so that it will help the reviewers.

You're right - will do next time. Too late for this, as I already sent
out v2. But as there was no feedback to the first round, you can just
ignore it entirely and just look at v2.


Thanks,
Daniel
