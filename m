From: stef <stef@hardco.de>
Subject: Re: ALSA vs OSS/free
Date: Thu, 07 Mar 2002 22:59:18 +0100
Message-ID: <3C87E2B6.51835970@hardco.de>
References: <Pine.LNX.4.44.0203071529210.923-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Kai Vehmanen <k@eca.cx>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

ALSA's midi routing/scheduling functionalities are unique.

Without this it would be impossible to use different midi
applications which also interact via midi, sync or share the
same hw interfaces.

For OSS i'm pretty sure you had to write a kernel part first
before you could start to code your midi app.

Stef(an).

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
