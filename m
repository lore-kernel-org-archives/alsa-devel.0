From: Andy Shevchenko <andy@smile.org.ua>
Subject: Re: Same pci id for different ASUS machine
Date: Mon, 17 Mar 2008 22:19:55 +0200
Message-ID: <20080317201955.GB10926@serv.smile.org.ua>
References: <1205376529.15217.8.camel@localhost.localdomain>
	<s5hskyvdqgu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from serv.smile.org.ua (serv.smile.org.ua [193.178.237.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 35B5F103830
	for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2008 21:20:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hskyvdqgu.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi Iwai!

 On Thu, Mar 13, 2008 at 08:37:37AM +0100, Takashi Iwai wrote next:

> The question is rather which one is "better".  At the time ASUS G1
> quirk was added, there was no lenovo model preset. 
The same situation was for some other ALC861 based laptop (uniwill vs.
asus?). Due to this I have question how to resolve this under windows for
example? Could we make more flex configuration in the ALSA instead of
hardcoded model= in the modprobe.conf?

-- 
With best regards,
Andy Shevchenko.      mailto: andy@smile.org.ua
