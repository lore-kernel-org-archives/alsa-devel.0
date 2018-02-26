From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Commit 8f7206d69a ("ASoC: imx-wm8962: Remove
 global variables") looks strange
Date: Mon, 26 Feb 2018 14:33:01 -0300
Message-ID: <CAOMZO5BUBai3fwZ+nDmSpvs+3nTki9h6t27CZZsBZrx7Q_kViw@mail.gmail.com>
References: <1519654860.13463.95.camel@nxp.com>
 <CAOMZO5DEF5EW9zu1qxy69x-1GU8rGCVN9iEJpRqLzRxZLEgMrA@mail.gmail.com>
 <1519656678.13463.98.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f169.google.com (mail-ot0-f169.google.com
 [74.125.82.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E729267556
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 18:33:03 +0100 (CET)
Received: by mail-ot0-f169.google.com with SMTP id t2so696169otj.4
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 09:33:03 -0800 (PST)
In-Reply-To: <1519656678.13463.98.camel@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: "S.j. Wang" <shengjiu.wang@nxp.com>, Leonard Crestez <leonard.crestez@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 26, 2018 at 11:51 AM, Daniel Baluta <daniel.baluta@nxp.com> wrote:

> Hmm,
>
> Looking into latest:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
>
> for-next branch and the commit in subject is the last on this file.
>
> Is there any other more updated tree/branch? Can you point the commit hash that did the re-arrangement.

Sorry, I was looking at the codec file instead of the machine driver one.

I will work on a fix.
