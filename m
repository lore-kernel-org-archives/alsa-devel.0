From: Duncan Sands <duncan.sands@math.u-psud.fr>
Subject: Re: 2.5.5-pre1 kernel - compile as modules?
Date: Fri, 15 Feb 2002 09:25:14 +0100
Message-ID: <E16bdgB-0001eP-00@baldrick>
References: <E16bNUh-0000Ne-00@baldrick> <20020214174703.GA28285@lineo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Received: from mel-rto7.wanadoo.fr (smtp-out-7.wanadoo.fr [193.252.19.26])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA22370
	for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2002 09:26:06 +0100
In-Reply-To: <20020214174703.GA28285@lineo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: curtisv@lineo.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Actually, the problem is deeper: even if I compile everything as
modules, I still get "no such device" when trying to read from
/proc/asound entries.  I will look into this further myself.

Duncan.

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
