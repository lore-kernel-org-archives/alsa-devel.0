From: David van Hoose <davidvh@cox.net>
Subject: Need help with 0.9.3c
Date: Wed, 28 May 2003 11:51:58 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3ED4DB1E.703@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I am running RedHat 9 with kernels 2.4.21-rc5 and 2.5.70-bk1.
I can get ALSA to work under 2.4.x with 0.9.2, but when I upgrade the
driver to 0.9.3c, I stop getting sound. I ran alsamixer and the volumes
are correct.
I'm using the snd-intel8x0 pci driver.
2.5.70 has 0.9.3c in it and it doesn't work either.
I tried isntalling 0.9.2 over it to see if it would work, but I get a
lot of errors from modversions saying that modules should use kernel
headers.

Can anyone help me?

Thanks,
David




-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
