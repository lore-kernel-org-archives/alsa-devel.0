From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: M-audio Audiophile Firewire
Date: Fri, 28 Oct 2016 10:30:03 +0900
Message-ID: <f677dfd1-c67d-7669-f4d4-d0dd5d8ff99e@sakamocchi.jp>
References: <CAPzTivG=yDAbFZo+u5qauE_LdpqhUM5fT9MT9+hrmi3gTsTGqw@mail.gmail.com>
 <1f6dd683-f550-651b-93d2-87560dd298ff@sakamocchi.jp>
 <fd56b817-96b3-1784-725c-21a5bef7497a@sakamocchi.jp>
 <CAPzTivEubUhef5LR_p3y0_4TZtbwoLimvzU-tx=xmUhBnT+T0g@mail.gmail.com>
 <CAPzTivHypNMZvBVBks=wpx1XakELyeWsBVD9mpq-risb_DtH=Q@mail.gmail.com>
 <7f5bc2fc-7e45-2577-9286-be0e2ff74228@sakamocchi.jp>
 <CAPzTivHqY1aBH2hqHetmd7-hdZsPbPsC8e1iMjgL=2myH91fbg@mail.gmail.com>
 <a2d308f4-1982-8418-40ec-e783065f7a96@sakamocchi.jp>
 <CAPzTivFtjdmpEOYJo=a=B12_Zf9UVV+SjRUKA9hNWLop3w5nbg@mail.gmail.com>
 <CAPzTivEPwnerkvH-Y5j9bvGzsM5GhLKvF69zFAkVHpDt-8g1Lw@mail.gmail.com>
 <20161023224350.GB12315@marvin.atrad.com.au>
 <5951c05f-3fe4-a2fc-aab2-407fddf8a817@gmail.com>
 <6f6374d3-f616-0d9d-31ac-2d463573f889@sakamocchi.jp>
 <80a6876e-6ced-7daa-7268-1277850c8270@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 6597D266AE2
 for <alsa-devel@alsa-project.org>; Fri, 28 Oct 2016 03:30:06 +0200 (CEST)
In-Reply-To: <80a6876e-6ced-7daa-7268-1277850c8270@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pap Peti <roachkiller44@gmail.com>, Jonathan Woithe <jwoithe@just42.net>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Oct 27 2016 23:10, Pap Peti wrote:
> My controller:
>
>
> *-firewire
>                    description: FireWire (IEEE 1394)
>                    product: XIO2200A IEEE-1394a-2000 Controller (PHY/Link)
>                    vendor: Texas Instruments
>                    physical id: 0
>                    bus info: pci@0000:06:00.0
>                    version: 01
>                    width: 32 bits
>                    clock: 66MHz
>                    capabilities: ohci bus_master cap_list
>                    configuration: driver=firewire_ohci latency=32
> maxlatency=4 mingnt=2
>                    resources: irq:19 memory:f1c04000-f1c047ff
> memory:f1c00000-f1c03fff

Not enough to re-generate your issue in my hand. Please inform below 
information to me:
  - applications in your test
  - operations in your test
  - the environment of your test; distribution, kernel version, and so on


Regards

Takashi Sakamoto
