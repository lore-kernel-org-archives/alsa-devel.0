From: cjw <cjw@daneel.dyndns.org>
Subject: powermac mixer doesn't work in 0.9.0beta12
Date: Thu, 7 Mar 2002 12:18:26 +0100 (CET)
Message-ID: <Pine.LNX.4.40.0203071217550.16614-100000@zem.cjw.nep>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from zem.cjw.nep (me@warande2090.warande.uu.nl [131.211.122.90])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA03042
	for <alsa-devel@alsa-project.org>; Thu, 7 Mar 2002 12:19:42 +0100
Received: from zem.cjw.nep (me@localhost.localdomain.127.in-addr.arpa [127.0.0.1] (may be forged))
	by zem.cjw.nep (8.12.1/8.12.1/Debian -5) with ESMTP id g27BIRp9016620
	for <alsa-devel@alsa-project.org>; Thu, 7 Mar 2002 12:18:27 +0100
Received: from localhost (cjw@localhost)
	by zem.cjw.nep (8.12.1/8.12.1/Debian -5) with ESMTP id g27BIQFN016617
	for <alsa-devel@alsa-project.org>; Thu, 7 Mar 2002 12:18:26 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On my beige G3, using the powermac driver, neither the oss mixer nor the
alsa native mixer work at all. Sound output works, but it is not possible
to enable play-through for the sound input, or to turn on the internal
speaker while something is plugged into the output jack. This all works
fine in 0.5.12a when I use an OSS mixer app (gmix). With 0.9.0beta12 there
are less sliders (0.5.x probably had too many :), and none of them works -
no error messages.


cheers,

    Christiaan



_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
