From: Alberto Manuel =?ISO-8859-1?Q?Brand=E3o_Sim=F5es?=
	 <albie@alfarrabio.di.uminho.pt>
Subject: Bug on alsa/hwdep.h
Date: 27 Mar 2002 09:09:21 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <a7s279$16i$2@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Received: from alfarrabio.di.uminho.pt (alfarrabio.di.uminho.pt [193.136.20.210])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id KAA08764
	for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2002 10:07:01 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-user@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


	If this is not a bug...

	in alsa/hwdep.h there is a line like:

typedef struct _snd_hwdep_info snd_hwdep_info_t;

This is correct... but where is the 'struct _snd_hwdep_info'?

Thanks for any quick answer!

Alberto
--=20
Alberto Manuel B. Simoes
Departamento de Inform=E1tica - Universidade do Minho
http://alfarrabio.di.uminho.pt/~albie - http://numexp.sf.net
