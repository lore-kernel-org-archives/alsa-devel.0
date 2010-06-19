From: Daniel Mack <daniel@caiaq.de>
Subject: Re: Status of the Tascam US-122mkII???
Date: Sat, 19 Jun 2010 19:42:59 +0200
Message-ID: <20100619174259.GJ17833@buzzloop.caiaq.de>
References: <AANLkTimaehZwC-e1pmbQl-pLNb7gVp2Rt5Ujz4BfduR_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id DC0F724606
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Jun 2010 19:43:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTimaehZwC-e1pmbQl-pLNb7gVp2Rt5Ujz4BfduR_@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jordan johnston <triplesquarednine@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 19, 2010 at 01:35:32PM -0400, jordan johnston wrote:
> Recently, i have gotten my hands on a Tascam US-122mkII.  i have done
> a lot of reading/googling and i can see that the device has been added
> to the snd-usb-us122l  and even-cross referenced my own device to make
> sure the Id and such were there.
> Currently, i am unable to get sound out of the Unit.   it does
> however, power up on boot.
> I have tried many things to get it working, and i have even gotten
> Jack to give me the option of picking this Device, however it shows
> errors
> and does not work :(

Could you please send the complete output of 'lsusb -v' with the device
connected?

Thanks,
Daniel
