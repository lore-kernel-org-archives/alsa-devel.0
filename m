From: Kasparek Tomas <xkaspa06@stud.fee.vutbr.cz>
Subject: Re: static alsa-lib is not working
Date: Thu, 18 Apr 2002 08:47:25 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.BSF.4.44.0204180846290.74102-100000@fest.stud.fee.vutbr.cz>
References: <Pine.LNX.4.33.0204180845110.526-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0204180845110.526-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 18 Apr 2002, Jaroslav Kysela wrote:

> On Wed, 17 Apr 2002, Kasparek Tomas wrote:

> Have you read the alsa-lib/INSTALL file?
>
> Compilation of static library
> -----------------------------
>
> If you would like to use the static ALSA library, you need to use these
> options for the configure script:
>
>         ./configure --enable-shared=no --enable-static=yes
>
> Unfortunately, due to bug in the libtool script, the shared and static
> library cannot be built together.

Hmm I did not, I sorry of disturbing you :(

Thanks

--

	Tomas Kasparek (sioux, xkaspa06)
 	 tomas.kasparek@[seznam.cz,volny.cz]
	 linux@fit.vutbr.cz
	student FIT VUT Brno
