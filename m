From: Frans Ketelaars <ketelaars@wanadoo.nl>
Subject: Re: new alsa docs.
Date: Sat, 10 Aug 2002 20:51:07 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020810205107.431ad249.ketelaars@wanadoo.nl>
References: <Pine.LNX.4.44.0208061855490.23759-100000@yme.mo.himolde.no>
	<3D52949C.6030706@boosthardware.com>
	<3D53606D.3020201@mindcom.fi>
	<3D5366C4.9050101@boosthardware.com>
	<3D536FD2.1030307@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D536FD2.1030307@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 09 Aug 2002 16:31:30 +0900
Patrick Shirkey <pshirkey@boosthardware.com> wrote:

> To make the module options complete I need someone to send me the output of
> 
>      modinfo $(modprobe -l snd-*) | cat > modules
> 
> when run on PPC and an ARM and a computer with old PnP cards/slots.
> 
> Run it as root user. It will write a file called modules to the 
> directory you run it from.
> 
> -- 
> Patrick Shirkey - Boost Hardware Ltd.
> For the discerning hardware connoisseur
> Http://www.boosthardware.com
> Http://www.boosthardware.com/LAU/guide/
> ========================================

This is with rc2 on ia32 with all (ISA card) modules. The 64K file is only 
attached to the message sent to Patrick. HTH, 

    -Frans



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
