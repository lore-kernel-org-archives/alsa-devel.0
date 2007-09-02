From: Ctirad Fertr <c.fertr@volny.cz>
Subject: Re: ESI MAYA44 driver status
Date: Mon, 3 Sep 2007 00:42:37 +0200
Message-ID: <200709030042.37769.c.fertr@volny.cz>
References: <87988a970708260156j3bee456djedcea8c74c54991f@mail.gmail.com>
	<46DAAB0B.8060500@gmail.com>
	<92a12cdb0709021050w2e4791d8te54ab3c2e68e5110@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.vol.cz (smtp3.vol.cz [195.250.128.83])
	by alsa0.perex.cz (Postfix) with ESMTP id 93A4E243A6
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Sep 2007 00:42:43 +0200 (CEST)
Received: from [10.16.3.4] (dsl-tn-6-43.static.adsl.vol.cz [83.148.7.43])
	by smtp3.vol.cz (Postfix) with ESMTP id 36FA4593EB
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Sep 2007 00:42:43 +0200 (CEST)
In-Reply-To: <92a12cdb0709021050w2e4791d8te54ab3c2e68e5110@mail.gmail.com>
Content-Disposition: inline
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

Dne Sunday 02 of September 2007 19:50:44 Adrian McMenamin napsal(a):
> ESI have said quite the opposite. They've actually said they'd make
> their engineers available to the person writing the device driver.

Nice ;) However, in this case it's probalbly not needed at all. The Maya44 is 
based on well known Envy24HT-S with a pair of Wolfson WM8776 codecs. Thus it 
should be quite simple to add suport into the snd-ice1724 driver. 

Regards,

Ctirad 
