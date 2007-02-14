From: "=?UTF-8?Q?Rafael_Esp=C3=ADndola?=" <rafael.espindola@gmail.com>
Subject: Re: trying to get sound working at a mac book pro
	(core 2 duo)
Date: Wed, 14 Feb 2007 20:56:18 +0000
Message-ID: <564d96fb0702141256t55f2febbna1e9bbdf50c200d@mail.gmail.com>
References: <564d96fb0702141121j185378d1m4c3a192831442fb7@mail.gmail.com>
	<1171482019.7083.8.camel@razman.gruemaster.com>
	<564d96fb0702141209g6b032115pebe2ce1a7e3de57b@mail.gmail.com>
	<564d96fb0702141235p4ed263fdnb14de941be27e334@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.226])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BAEB82ED
	for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2007 21:56:19 +0100 (MET)
Received: by nz-out-0506.google.com with SMTP id l8so307489nzf
	for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2007 12:56:19 -0800 (PST)
In-Reply-To: <564d96fb0702141235p4ed263fdnb14de941be27e334@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> I was reading the ICH7 document from Intel and now I am confused. The
> subsystem that the document refers to is the PCI one. What subsystem
> is listed in the codec file?

I was really confused. The Codec also has a subsystem ID, which is
available with the verb f20 and is displayed on /proc. This is the
subsystem that is different from the two mac book versions.

Rafael

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
