From: Guenther Sohler <guenther.sohler@newlogic.com>
Subject: Re: 2.5.5-pre1 kernel - compile as modules?
Date: Fri, 15 Feb 2002 09:30:35 +0100 (MET)
Message-ID: <XFMail.020215093035.guenther.sohler@newlogic.com>
Reply-To: Guenther Sohler <guenther.sohler@newlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Received: from enterprise2.newlogic.com (enterprise2.newlogic.at [194.208.88.1])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA22487
	for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2002 09:31:14 +0100
Received: from enterprise2.newlogic.com (enterprise2 [172.27.1.1])
	by enterprise2.newlogic.com (8.9.2/8.9.2) with ESMTP id JAA29679
	for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2002 09:30:38 +0100 (MET)
In-Reply-To: <E16bdgB-0001eP-00@baldrick>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: curtisv@lineo.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

did you insmod the snd.o ???

On 15-Feb-02 Duncan Sands wrote:
> Actually, the problem is deeper: even if I compile everything as
> modules, I still get "no such device" when trying to read from
> /proc/asound entries.  I will look into this further myself.
> 
> Duncan.
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

Guenther Sohler

NewLogic Technologies AG 
Millennium Park 6
A-6890 Lustenau
                                           Phone: +43-5577-62000-507
E-Mail: guenther.sohler@newlogic.com       Fax:   +43-5577-62000-988


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
