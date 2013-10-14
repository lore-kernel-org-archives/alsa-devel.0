From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: dsp after dmix
Date: Mon, 14 Oct 2013 09:50:00 +0200
Message-ID: <CAOf5uwnFtN4mDqgfLThRXGUcHQpFJ6wkFFoZhBJdWc6FaBPapg@mail.gmail.com>
References: <CAOf5uwmrS1AZrmKfbUYokU1Azdd2dZv2=Z=fGp+UQyy_mW1ijQ@mail.gmail.com>
 <525B985A.30409@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f52.google.com (mail-wg0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id A7D1E26030E
 for <alsa-devel@alsa-project.org>; Mon, 14 Oct 2013 09:50:00 +0200 (CEST)
Received: by mail-wg0-f52.google.com with SMTP id f12so1065120wgh.31
 for <alsa-devel@alsa-project.org>; Mon, 14 Oct 2013 00:50:00 -0700 (PDT)
In-Reply-To: <525B985A.30409@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Clemens

On Mon, Oct 14, 2013 at 9:08 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Michael Trimarchi wrote:
>> My problem is to apply filtering after dmix plugin.
>
> The dmix plugin works only on top of a "hw" device.
>

Yes I have seen the code. Is there anyway to work with dps without passing
thought pulseaudio? (arm9 is to heavy)

Michael

>
> Regards,
> Clemens
